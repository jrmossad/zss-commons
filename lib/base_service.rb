require 'zss'
class BaseService

  DEFAULT_PAGE_LIMIT = 50
  DEFAULT_FIRST_PAGE = 1
  DEFAULT_PAGE_SIZE = 10

  protected

  def ensure_pagination(payload)
    payload.page ||= first_page
    payload.per_page ||= page_size
    raise ZSS::Error.new(400, "Per page should be <= #{per_page_limit}") if payload.per_page > per_page_limit
  end

  private

  def per_page_limit
    @page_limit || DEFAULT_PAGE_LIMIT
  end

  def first_page
    @first_page || DEFAULT_FIRST_PAGE
  end

  def page_size
    @page_size || DEFAULT_PAGE_SIZE
  end

end
