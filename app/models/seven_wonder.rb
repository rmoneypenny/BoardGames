class SevenWonder < ApplicationRecord

	validates :score, presence: true

	def getnames(all="no")
		if all == "all"
			SevenWonder.pluck("DISTINCT name")
		else
			SevenWonder.where(:date => (30.days.ago..DateTime.now)).pluck("DISTINCT name")
		end
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
	end

	def uniqueboards(player)
		a = []
		player.select(:boardname).each do |n|
			a.push(n.boardname)
		end
		s = self.allboards - a.uniq
		if s.empty?
			self.allboards
		else
			self.allboards - a.uniq
		end
	end

	def getNextGameNumber
		s = SevenWonder.last.gamenumber
		s += 1
	end

	def submitGame(name, boardname, score)
		if score
			winloss = self.highestScore(score)
			games = name.zip(boardname, score, winloss)
			s = self.getNextGameNumber
			games.each do |g|
				SevenWonder.create(gamenumber: s, name: g[0], boardname: g[1], score: g[2], win: g[3], date: DateTime.now)
			end
		end



	end

	def highestScore(score)
		score.map! {|s| s.to_i}
		highest = score.sort.last
		winloss = []
		i=0
		score.size.times do
			if score[i] == highest
				winloss.push(true)
			else
				winloss.push(false)
			end
			i+=1
		end
		winloss
	end

	def getTodaysGames
		s = SevenWonder.where(:date => (1.days.ago..DateTime.now))
		gamenumbers = []
		names = []
		boardnames = []
		scores = []
		winloss = []
		games = []
		wl = []
		s.each do |r|
			gamenumbers.push(r.gamenumber)
			names.push(r.name)
			boardnames.push(r.boardname)
			scores.push(r.score)
			wl.push(r.win)
		end
		wl.each do |w|
			if w
				winloss.push("win")
			else
				winloss.push("lose")
			end
		end
		games = gamenumbers.zip(names, boardnames, scores, winloss)
		games

	end

	def winners
		games = self.getTodaysGames
		winner = []
		winnercount = Hash.new(0)
		games.each do |w|
			if w[4] == "win"
				winner.push(w[1])
			end
		end
		winner.each do |r|
			winnercount[r] += 1
		end
		winnercount
	end

	def gameHistory
		n = SevenWonder.last.gamenumber
		s = SevenWonder.where(gamenumber: n-10..n)
		s
	end

	def boardwinper
		a = self.allboards
		p = []
		a.each do |b|
			t = SevenWonder.where(boardname: b).count
			w = SevenWonder.where(boardname: b, win: true).count
			puts t
			puts w
			p.push(((w.to_f/t.to_f)*100).round(1))
		end
		winp = a.zip(p)
		winp.sort_by{|x,y|y}.reverse
	end

	def winper
		names = self.getnames
		p = []
		names.each do |n|
			t = SevenWonder.where(name: n).count
			w = SevenWonder.where(name: n, win: true).count
			p.push(((w.to_f/t.to_f)*100).round(1))
		end
		winp = names.zip(p)
		winp.sort_by{|x,y|y}.reverse
	end

	def playerStats
		names = self.getnames("all")
		highest = []
		lowest = []
		board = []
		names.each do |n|
			highest.push(SevenWonder.where(name: n).maximum(:score))
			lowest.push(SevenWonder.where(name: n).minimum(:score))
			board.push(self.bestPlayerBoard(n))
		end
		names.zip(highest,lowest,board).sort_by{|x,y,z,a| y}.reverse
	end

	def bestPlayerBoard(name)
		winningGames = SevenWonder.where(name: name, win: true)
		winningBoards = []
		winningGames.each do |n|
			winningBoards.push(n.boardname)
		end
		winningBoards.sort
		uniqueboards = winningBoards.uniq
		count = 0
		name = ""
		uniqueboards.each do |u|
			if winningBoards.count(u) > count
				count = winningBoards.count(u)
				name = u
			end
		end
		best = [name,count]
	end

	def allPlayerBoards(name)
		s = SevenWonder.where(name: name)
		boards = self.uniqueboards(s)
		boards
	end 

end


=begin
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
=end
