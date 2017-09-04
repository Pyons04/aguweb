
class Scrapingsylabas3
  require 'mechanize'
  def  self.movie_url
    puts"--------------------------------------"
    puts"          ScrapingSylabas"
    puts"--------------------------------------"
    puts"スクレイピングするアドレスを入力してください"
    first_url=gets.to_s
    puts"シラバスの年度を入力してください(入力すると開始します)"
    academic_year=gets.to_i
    # ページ数の確認
    agent=Mechanize.new
    page=agent.get(first_url)
    number_of_units=page.at('#ContentPlaceHolder1_lblHitMsg').inner_text.to_i if page.at('#ContentPlaceHolder1_lblHitMsg')
    number_of_pages=number_of_units/19.ceil
    sleep(2)
    #ページ数の確認終わり
    #学部の確認
    major=page.at('#ContentPlaceHolder1_gvw_kensaku_lblKaikou_0').inner_text.to_s if page.at('#ContentPlaceHolder1_gvw_kensaku_lblKaikou_0')
    sleep(2)
    #学部の確認終わり
    links=[]
    next_url=1.to_i
    binding.pry

    while next_url<number_of_pages do        #この数字はページ数+1
     current_page=(first_url.to_s + next_url.to_s)
      links<<current_page
      next_url = next_url.to_i+1
    end
  get_product(links,academic_year,major)
  end



def self.get_product(links,academic_year,major)


  agent=Mechanize.new
  links.each do |link|
  page=agent.get(link)
  table=1.to_i

  while table<20 do
  jigen=page.at('#ContentPlaceHolder1_gvw_kensaku_lblJigen_' + table.to_s).inner_text if page.at('#ContentPlaceHolder1_gvw_kensaku_lblJigen_' + table.to_s)
  kamoku=page.at('#ContentPlaceHolder1_gvw_kensaku_lblKamoku_' + table.to_s).inner_text if page.at('#ContentPlaceHolder1_gvw_kensaku_lblKamoku_' + table.to_s)
  kyouin=page.at('#ContentPlaceHolder1_gvw_kensaku_lblKyouin_' + table.to_s).inner_text if page.at('#ContentPlaceHolder1_gvw_kensaku_lblKyouin_' + table.to_s)
  unit=Unit.where(jigen: jigen,kyouin: kyouin).first_or_initialize
  unit.jigen=jigen
  unit.kamoku=kamoku
  unit.kyouin=kyouin
  unit.year=academic_year.to_i
  unit.kaikou=major.to_s
  unit.save #unless kamoku==kamoku.where('kamoku LIKE(?)',"%演習%")
  table=table+1
  sleep(2)  #サーバーへの負荷防止
   end
 end
end

end