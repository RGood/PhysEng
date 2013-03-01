require "./PhysEng"

uni = Universe.new([],0.003) #creates a universe space with no planets and a max delta time per calculation of 7 milliseconds

uni.addBody(CB.new("Mass 1",5972198600000000000000000,[0,0,0])) # adds a body with 1000 kg mass to the universe at location 10 meters by 10 meters by 0 meters
uni.addBody(CB.new("Mass 2",500000000000000000,[0,6367500,0],[7000,0,0])) # adds a body with 500 kg mass to the universe at location 0 meters by 10 meters by 5 meters
uni.addBody(CB.new("Mass 3",200000,[0,6387500,0],[7200,0,0])) # adds a body with 2000 kg mass to the universe at location 7 meters by 0 meters by 8 meters
uni.reportAll # list the initial positions of all of the bodies

location = File.open("planetLocation.csv",'w')
pos = uni.reportPos("Mass 2")
location.write(pos[0].to_s+","+pos[1].to_s+"\n")

thread = Thread.new{uni.run} # initialize the thread
start = Time.now;puts("Starting simulation...") # record the time and notify the user that the simluation is begining

pos = uni.reportPos("Mass 2")
location.write(pos[0].to_s+","+pos[1].to_s+"\n")

thread.run # begin the simulation

for i in 0..4000 # print 5 reports over 5 seconds about the location of all of the bodies in the universe
	#puts("##########Report "+i.to_s+"##########")
	if(i == 1000)
		puts("25%")
	elsif(i == 2000)
		puts("50%")
	elsif(i==3000)
		puts("75%")
	elsif(i==4000)
		puts("100%")
	end
	sleep(1)
	pos = uni.reportPos("Mass 3")
	location.write(pos[0].to_s+","+pos[1].to_s+"\n")
	#puts("#######End of report########")
end

location.close

# the reason I did this instead of programming the universe to run for a specific amount of time, then write a report
# was to prove the concept that the universe could be set up, then other things could be done, while pulling data
# from the universe at any required time. It's extremely cool.

uni.halt # freeze the universe
runTime = Time.now-start # record the time that the program ran for
uni.reportAll # report the final positions of all bodies in the universe
puts("Time(s): "+(runTime).to_s) # display the runtime
puts("Artificual universe time since start(s): " + uni.timeSinceStart.to_s) # display the artificial univere's elapsed time
puts("Artificial universe functions at: " +(uni.timeSinceStart/runTime).to_s + " seconds per second") # display the ratio between the two times
