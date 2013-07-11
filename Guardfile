# -*- mode: ruby -*-
# More info at https://github.com/guard/guard#readme

$count = 0
$previous = Time.now

guard :shell do
#  watch(/_posts\/.+\.markdown/) do |x| #
  watch(/_blogofile\/_posts\/.*/) do |x|
    t = Time.now
    if t - $previous > 5
      $count += 1
      puts `cd _blogofile && blogofile build`
      puts "build #{$count} #{t}: #{x}"
      $previous = t
    else
      puts "skipping #{x}"
    end
  end
end
