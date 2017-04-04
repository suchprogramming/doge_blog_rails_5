module FilterableHelper
  def post_date_filters
    [
      ['Posts from', nil, disabled: true, selected: true],
      ['Last Day', 1.day.ago.strftime('%Y-%m-%d')],
      ['Last Week', 1.week.ago.strftime('%Y-%m-%d')],
      ['Last Month', 1.month.ago.strftime('%Y-%m-%d')],
      ['Last Year', 1.year.ago.strftime('%Y-%m-%d')]
    ]
  end
end
