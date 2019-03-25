module ApplicationHelper
  def full_title(page_title = '')
    base_title = getApplicationTitle
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def getApplicationTitle
    '洋書おすすめ検索'
  end
end
