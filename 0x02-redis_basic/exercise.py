#!/usr/bin/env python3
"""writing strings to redis"""

import redis
import uuid
from typing import Union, Callable, Optional


class Cache:
    """initializes redis clients and flush the database"""
    def __init__(self):
        self._redis = redis.Redis()
        self._redis.flushdb()

    def store(self, data: Union[str, bytes, int, float]) -> str:
        """stores data in Redis with randomly generated key"""
        key = str(uuid.uuid4())
        self._redis.set(key, data)
        return key

    def get(self, key: str, fn: Optional[Callable[[bytes], Union[str, int,
            float, bytes]]] = None) -> Optional[Union[str, int, float, bytes]]:
        """
        Retrieve data from Redis and optionally apply a conversion function
        """
        data = self._redis.get(key)

        if data is None:
            return None

        if fn is not None:
            return fn(data)

        return data

    def get_str(self, key: str) -> Optional[str]:
        """
        Retrieve a string from Redis.

        Args:
            key: The key to retrieve data for.

        Returns:
            The data as a decoded string, or None if the key does not exist.
        """
        return self.get(key, lambda d: d.decode('utf-8'))

    def get_int(self, key: str) -> Optional[int]:
        """
        Retrieve an integer from Redis.

        Args:
            key: The key to retrieve data for.

        Returns:
            The data as an integer, or None if the key does not exist.
        """
        return self.get(key, lambda d: int(d))
