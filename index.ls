Buffer::concat = (o)-> Buffer.concat [this,o]

Readable::take = (n)->
	orig = this

	new class extends Readable
		->
			super ...
			@consumed = new Buffer ""
			@n = n
		_read: (size)->
			return @push null if @n is 0
			if size < @n
				if (orig.read size)?
					@push that
					@consumed ++= that
					@n -= that.length
				else @push ""
			else
				if (orig.read n)?
					@push that.slice 0 @n
					@consumed ++= that
				@push null
				orig.unshift @consumed