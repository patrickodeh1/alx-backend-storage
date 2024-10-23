#!/usr/bin/env python3
"""Module to fetch and cache web page content."""

import redis
import requests
from typing import Callable
import functools

r = redis.Redis()

def cache_page(expiration: int = 10):
    """
    Decorator to cache the result of a function call for a given expiration time.
    """
    def decorator(method: Callable) -> Callable:
        @functools.wraps(method)
        def wrapper(url: str) -> str:
            cached_content = r.get(f"cached:{url}")
            if cached_content:
                return cached_content.decode('utf-8')

            result = method(url)
            r.setex(f"cached:{url}", expiration, result)
            return result
        return wrapper
    return decorator

@cache_page(expiration=10)
def get_page(url: str) -> str:
    """
    Fetches the HTML content of a URL, caches it for 10 seconds,
    and tracks how many times the URL was accessed.
    """
    r.incr(f"count:{url}")

    response = requests.get(url)
    return response.text
