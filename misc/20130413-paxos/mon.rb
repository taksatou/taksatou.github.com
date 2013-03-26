#!/usr/bin/env ruby

require 'fssm'

if __FILE__ == $0
  FSSM.monitor './_posts' do
    update { |base, relative| puts `make` }
    delete { |base, relative| puts `make` }
    create { |base, relative| puts `make` }
  end
end
