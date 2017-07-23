module CiniisHelper

  PER_PAGE_NUM = 4
  MAX_SIZE_NUM = 100

  def per_page_num
    PER_PAGE_NUM
  end

  def render_search_form?
    params[:lab_id].blank? && params[:feature].blank? && params[:q].blank?
  end

  def paginate_id?(object_id)
    object_id % PER_PAGE_NUM == 0
  end

  def pagination_number(object_id)
    object_id / PER_PAGE_NUM
  end

  def until_max_size(result_length)
    result_length / (MAX_SIZE_NUM + 1) == 0
  end

  def display_contents?(object_id, page_number)
    page_number * PER_PAGE_NUM < object_id && object_id <= (page_number + 1) * PER_PAGE_NUM
  end
end
