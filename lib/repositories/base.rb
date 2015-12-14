module Repository
  class Base

    protected

    def paginate(query, page, per_page)
      offset = get_offset(page, per_page)
      query.limit(per_page).offset(offset)
    end

    def get_offset(page, per_page)
      (page - 1 ) * per_page
    end

  end
end
