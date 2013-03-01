class CB
	@pos=[0,0,0]
	@vel=[0,0,0]
	@name = ""
	@mass = 1
	
	def initialize(n="unknown body",m=1,p=[0,0,0],v=[0,0,0])
		@pos = p
		@vel = v
		@name = n
		@mass = m
	end
	
	def name
		@name
	end
	
	def pos
		@pos
	end
	
	def vel
		@vel
	end
	
	def setPos(p)
		@pos = p
	end
	
	def setVel(v)
		@vel = v
	end
	
	def mass
		@mass
	end
	
	def report
		return @name + " is at location: " + @pos.to_s
	end
	
end

class Universe
	@bodies = []
	@maxDV = 7
	@lastTime = 0
	@running = true
	@uniTime
	@numObjects = 0
	@timeSinceStart = 0
	G = 0.0000000000667398
	def initialize(b=[],mDV = 0.007)
		@bodies = b
		@lastTime = Time.now
		@maxDV = mDV
		@uniTime = Time.now
		@timeSinceStart = 0
		@numObjects = b.size
	end
	
	def numObjects
		@numObjects
	end
	
	def bodies
		@bodies
	end
	
	def run(time=-1)
		@running = true
		while(@running)
			#puts("here")
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
					if(cb.name!=b.name)
						x = cb.pos[0]-b.pos[0]
						y = cb.pos[1]-b.pos[1]
						z = cb.pos[2]-b.pos[2]
						accel[0]+= ((x * G * cb.mass) / ((x.abs+y.abs+z.abs)*(x*x+y*y+z*z)))
						accel[1]+= ((y * G * cb.mass) / ((x.abs+y.abs+z.abs)*(x*x+y*y+z*z)))
						accel[2]+= ((z * G * cb.mass) / ((x.abs+y.abs+z.abs)*(x*x+y*y+z*z)))
					end
				end
				
				
				
				#puts(b.pos.to_s)
				oldPos = b.pos
				oldVel = b.vel
				newVel = [accel[0]*timeDif + oldVel[0],accel[1]*timeDif+oldVel[1],accel[2]*timeDif+oldVel[2]]
				newPos = [oldPos[0]+newVel[0]*timeDif,oldPos[1]+newVel[1]*timeDif,oldPos[2]+newVel[2]*timeDif]
				b.setPos(newPos)
				b.setVel(newVel)
			end
			if(time!=-1)
				if(timeSinceStart>=time)
					@running=false
				end
			end
		end
	end
	
	def halt
		@running = false
	end
	
	def reportAll
		@bodies.each do |b|
			puts b.report
		end
	end
	
	def reportPos(name)
		@bodies.each do |b|
			if(b.name == name)
				return b.pos
			end
		end
	end

	def reportAllVel
		@bodies.each do |b|
			puts b.vel
		end
	end
	
	def listBodies
		@bodies.each do |b|
			puts b.name
		end
	end
	
	def timeSinceStart
		@timeSinceStart
	end
	
	def addBody(body)
		@bodies.insert(-1,body)
		@numObjects += 1
	end
	
	def remBody(name)
		@bodies.each do |b|
			if(b.name == name)
				@bodies.delete(b)
				@numObjects -= 1
				return
			end
		end
	end
end
