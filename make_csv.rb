require "csv"

bpm = 132
clock = 120
base_beat = bpm/clock.to_f
 
CSV.open('./data/timing.csv','w') do |r|
	(1..200).each do |n|
		r << [(n * base_beat).floor(2), [0,1,2].sample]
	end
end

