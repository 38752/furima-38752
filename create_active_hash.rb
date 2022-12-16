def create_active_hash
  puts 'class名を入力してください'
  active_hash = "class #{gets.chomp} < ActiveHash::Base\n  self.data = [\n"
  list = []
  input = ''
  while input != 'finished'
    puts "#{list.length + 1}番目の要素を入力してください"
    input = gets.chomp
    case input
    when 'finished'
    when 'rollback'
      if list.empty?
        puts '要素はありません'
      else
        puts "#{list.length}番目の要素：#{list.slice!(-1)}を取り除きました"
      end
    when 'blank'
      list << ''
    when ''
      puts "入力がありませんでした\n空で登録したい場合はblankと入力してください"
    else
      list << input
    end
  end
  i = 1
  list.each do |name|
    active_hash += "    { id: #{i}, name: '#{name}' },\n"
    i += 1
  end
  puts active_hash += "  ]\n\n  include ActiveHash::Associations\nend"
end

# 使う時だけコメントアウト外す
# create_active_hash
