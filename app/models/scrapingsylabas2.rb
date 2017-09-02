
class Scrapingsylabas2
  require 'mechanize'
  def  self.movie_url
    links=[]
    next_url=1.to_i

    while next_url<33 do        #この数字はページ数+1
     current_page=("http://syllabus.aoyama.ac.jp/?__EVENTTARGET=&__EVENTARGUMENT=&__VIEWSTATEGENERATOR=309A73F1&YR=2017&BU=BU1&GB1A=&GB2A=&GB3A=&GB1B=611200&GB2B=&GB3B=&GB4B=&GB5B=&KI=&KM=&CP=&YB=&JG=&GKA=&GKB=&GKT=&KW=&btnKensaku=%E6%A4%9C%E7%B4%A2&ST=&PG=" + next_url.to_s)
      links<<current_page
      next_url = next_url.to_i+1
    end
  get_product(links)
  end



def self.get_product(links)


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
  unit.year=2017
  unit.kaikou="経済"
  unit.save #unless kamoku==kamoku.where('kamoku LIKE(?)',"%演習%")
  table=table+1
  sleep(2)  #サーバーへの負荷防止
   end
 end
end

end