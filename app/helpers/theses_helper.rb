module ThesesHelper
  NO_LABO_ID = 9

  def display_abst_or_body(thesis)
    thesis.summary == "" ?  thesis.body.truncate(1000) : thesis.summary
  end
end
