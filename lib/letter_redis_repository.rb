class LetterRedisRepository
  def self.top
    redis = Redis.new
    list  = redis.zrevrange "top_letters", 0, 9 # retrieves a list in reverse order of a sorted set.
    if list.empty?
      letters = Letter.limit(10).order(score: :desc)
      letters.each do |letter| 
        redis.zadd "top_letters", letter.score, letter.id  # takes a name of the collection and a name of an id
      end
      return letters.map(&:id)
    else
      return list
    end
  end
end