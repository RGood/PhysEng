require "./PhysEng"
require "test/unit"
 
class TestPhysEng < Test::Unit::TestCase
 
	def test_create_body
		testBody = CB.new()
		assert_not_nil(testBody)
		assert_equal("unknown body",testBody.name)
		assert_equal("unknown body is at location: [0, 0, 0]",testBody.report)
	end
	
	def test_create_universe
		uni = Universe.new
		assert_not_nil(uni)
		assert_equal(0,uni.numObjects)
	end
	
	def test_add_body_to_universe
		uni = Universe.new
		testBody = CB.new()
		uni.addBody(testBody)
		assert_equal(1,uni.numObjects)
		uni.addBody(CB.new("Object 1",5000,[1,1,1]))
		assert_equal(2,uni.numObjects)
		uni.remBody("Object 1")
		assert_equal(1,uni.numObjects)
	end
	
#	def test_simulation
#		uni = Universe.new
#		uni.addBody(CB.new)
#		uni.addBody(CB.new("Object 1",5000000,[5,5,5]))
#		uni.addBody(CB.new("Object 2",2000000,[-1,2,-4]))
#		uni.reportAll
#		thread = Thread.new{uni.run}
#		start = Time.now;puts("Starting simulation...")
#		thread.run
#		sleep(59)
#		uni.reportAll
#		uni.halt
#		puts("Time(s): "+(Time.now-start).to_s)
#		puts("Artificual universe time since start(s): " + uni.timeSinceStart.to_s)
#	end
	
	def test_simulation2
		uni = Universe.new([],0.007)
		sunMass = 50000000000
		eMass = 500000000
		uni.addBody(CB.new("Sun",sunMass,[0,0,0]))
		uni.addBody(CB.new("Earth",eMass,[500,0,0],[0,4,0]))
		uni.reportAll
		thread = Thread.new{uni.run}
		start = Time.now;puts("Starting simulation...")
		thread.run
		sleep(0.001)
		uni.halt
		runTime = Time.now-start
		uni.reportAll
		puts("Time(s): "+(runTime).to_s)
		puts("Artificual universe time since start(s): " + uni.timeSinceStart.to_s)
		puts("Universe functions at: " +(uni.timeSinceStart/runTime).to_s + " seconds per second")
	end
 
end