# -*- mode: ruby -*-
# More info at https://github.com/guard/guard#readme

$count = 0

guard :shell do
#  watch(/_posts\/.+\.markdown/) do |x| #
  watch(/_blogofile\/_posts\/.*/) do |x|
    $count += 1
    puts `cd _blogofile && blogofile build`
    puts "#{$count} #{Time.now}"
  end
end
