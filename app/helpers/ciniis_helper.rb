module CiniisHelper
  def render_search_form?
    params[:lab_id].blank? && params[:feature].blank? && params[:q].blank?
  end
end
