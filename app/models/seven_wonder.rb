class SevenWonder < ApplicationRecord

	def getnames
		SevenWonder.pluck("DISTINCT name")
	end

	def allboards
		a = []
		Swboardname.select(:name).each do |n|
			a.push(n.name)
		end
		a
	end

	def playerboards(name)
		s = SevenWonder.where(:name => name)
		boards = self.uniqueboards(s)
		boards[rand(boards.size)]
		#SevenWonder.pluck("DISTINCT name")
	end

	def uniqueboards(player)
		a = []
		player.select(:boardname).each do |n|
			a.push(n.boardname)
		end
		self.allboards - a.uniq
	end

	def getNextGameNumber
		s = SevenWonder.last.gamenumber
		s += 1
	end

	def submitGame(name, boardname, score)
		a = []
		n = name.size
		i = 0
		currentGameNumber = self.getNextGameNumber
		while i<n do 
			a.push(name[i])
			a.push(boardname[i])
			a.push(score[i])
			s = SevenWonder.create(gamenumber: currentGameNumber, name: a[0], boardname: a[1], score: a[2], win: false, date: DateTime.now)
			s.save
			i += 1
		end
	end

end
