#!/usr/bin/env python3
"""Module to fetch and cache web page content."""

import redis
import requests
from typing import Callable

r = redis.Redis()

def get_page(url: str) -> str:
    """
    Fetches the HTML content of a URL and caches the result for 10 seconds.
    Tracks how many times a URL was accessed.
    """
    cached_content = r.get(f"cached:{url}")
    if cached_content:
        return cached_content.decode('utf-8')

    r.incr(f"count:{url}")

    response = requests.get(url)
    html_content = response.text

    r.setex(f"cached:{url}", 10, html_content)

    return html_content
