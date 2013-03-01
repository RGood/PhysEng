class CB #basic Celestial Body class
	@pos=[0,0,0] #body position defaults to coordinates 0,0,0
	@vel=[0,0,0] #body velocity defaults to x, y, and z values of 0
	@name = ""   #body name initially not set
	@mass = 1    #bass defaults to 1
	
	def initialize(n="unknown body",m=1,p=[0,0,0],v=[0,0,0])
		@pos = p
		@vel = v
		@name = n
		@mass = m
	end
	
	def name #returns body name
		@name
	end
	
	def pos #returns body x,y,z positions
		@pos
	end
	
	def vel #returns body x,y,z velocities
		@vel
	end
	
	def setPos(p) #set position
		@pos = p
	end
	
	def setVel(v) #set velocity
		@vel = v
	end
	
	def mass #returns body mass
		@mass
	end
	
	def report #prints basic report of body in a string format
		return @name + " is at location: " + @pos.to_s
	end
	
end

class Universe #Universe class
	@bodies = [] #defaults with no bodies
	@maxDV = 0.007 #defaults to maximum 7 millisecond change in time
	@lastTime = 0
	@running = false #defaults running to false
	@uniTime #universe time
	@numObjects = 0 #number of objects in the universe
	@timeSinceStart = 0 #time ellapsed with the universe running
	G = 0.0000000000667398
	def initialize(b=[],mDV = 0.007)
		@bodies = b
		@lastTime = Time.now
		@maxDV = mDV
		@uniTime = Time.now
		@timeSinceStart = 0
		@numObjects = b.size
	end
	
	def numObjects #returns the number of objects in the universe
		@numObjects
	end
	
	def bodies #returns the list of planets in the universe
		@bodies
	end
	
	def run(time=-1) #runs the universe for "time" seconds or until uni.halt is called
		@running = true
		while(@running)
			timeDif = Time.now - @lastTime
			@lastTime = Time.now
			if(timeDif > @maxDV)
				timeDif = @maxDV
			end
			@uniTime += timeDif
			@timeSinceStart += timeDif
			@bodies.each do |b|
				totalForce = 0
				
				accel=[0,0,0]
				
				@bodies.each do |cb|
					if(cb.name!=b.name) #calculating total acceleration
						x = cb.pos[0]-b.pos[0]
						y = cb.pos[1]-b.pos[1]
						z = cb.pos[2]-b.pos[2]
						accel[0]+= ((x * G * cb.mass) / ((x.abs+y.abs+z.abs)*(x*x+y*y+z*z)))
						accel[1]+= ((y * G * cb.mass) / ((x.abs+y.abs+z.abs)*(x*x+y*y+z*z)))
						accel[2]+= ((z * G * cb.mass) / ((x.abs+y.abs+z.abs)*(x*x+y*y+z*z)))
					end
				end
				
				oldPos = b.pos
				oldVel = b.vel
				newVel = [accel[0]*timeDif + oldVel[0],accel[1]*timeDif+oldVel[1],accel[2]*timeDif+oldVel[2]] #calculating new velocity
				newPos = [oldPos[0]+newVel[0]*timeDif,oldPos[1]+newVel[1]*timeDif,oldPos[2]+newVel[2]*timeDif] #calculating new position
				b.setPos(newPos) #setting position
				b.setVel(newVel) #setting velocity
			end
			if(time!=-1)
				if(timeSinceStart>=time)
					@running=false
				end
			end
		end
	end
	
	def halt #halts the universe
		@running = false
	end
	
	def reportAll #puts the report of every planet
		@bodies.each do |b|
			puts b.report
		end
	end
	
	def reportPos(name) #return the position of the planet with the specified name
		@bodies.each do |b|
			if(b.name == name)
				return b.pos
			end
		end
	end

	def reportAllVel #prints all velocities. <- needs changing
		@bodies.each do |b|
			puts b.vel
		end
	end
	
	def listBodies #lists all body names
		@bodies.each do |b|
			puts b.name
		end
	end
	
	def timeSinceStart #returns the ellapsed time that the universe has been running for
		@timeSinceStart
	end
	
	def addBody(body) #add a body to the universe
		@bodies.insert(-1,body)
		@numObjects += 1
	end
	
	def remBody(name) #remove the 1st body with the name passed in.
		@bodies.each do |b|
			if(b.name == name)
				@bodies.delete(b)
				@numObjects -= 1
				return
			end
		end
	end
end
