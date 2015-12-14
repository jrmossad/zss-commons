# zss-commons

This project includes base classes for zss services, dtos, repositories and mappers

## DTO::Base

Zss DTOs should extend this class. It provides a default initializer, serializer and ==.
The initializer receives a hash. Any attributes which match the hash key will be initialized with the hash value.

## BaseService

All services should extend this class. At this time it only provides the protected method ensure_pagination which paginates a zss payload.
The defaults for pagination are:
* DEFAULT_PAGE_LIMIT = 50
* DEFAULT_FIRST_PAGE = 1
* DEFAULT_PAGE_SIZE = 10

If you wish to override these, your subclass must set instance variables page_limit, first_page or page_size with the desired values

## Repository::Base

All repositories should extend this class. At this time it only provides the helper method paginate, which receives an AR query, a page and a page size and applies to corresponding ar limit and offset to the query.

## Mapper::Base

All mapper should extend this class. It provides the default class methods map, to_dao and to_dto. The map method converts a DTO into a DAO and vice versa. All subclasses must implement to_dao and to_dto

## DTO#Bulk

Helper class for dealing with bulk DTO::Paginated data

## DTO::Paginated

Wrapper for DTO pagination. Adds pagination to enumerable dtos
