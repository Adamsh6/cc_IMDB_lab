require("pry")
require_relative('models/casting')
require_relative('models/movie')
require_relative('models/star')

Star.delete_all
Movie.delete_all
Casting.delete_all


star1 = Star.new({'first_name' => 'Bruce', 'last_name' => 'Willis'})
star2 = Star.new({'first_name' => 'Margot', 'last_name' => 'Robbie'})
star3 = Star.new({'first_name' => 'Danny', 'last_name' => 'DeVito'})
star4 = Star.new({'first_name' => 'Scott', 'last_name' => 'Eastwood'})
star5 = Star.new({'first_name' => 'Natalie', 'last_name' => 'Portman'})
star1.save
star2.save
star3.save
star4.save
star5.save

movie1 = Movie.new({'title' => 'Mindbreaker', 'genre' => 'thriller', 'budget' => 1000})
movie2 = Movie.new({'title' => 'The Elves of Shoom', 'genre' => 'fantasy', 'budget' => 5000})
movie3 = Movie.new({'title' => 'Serious Business', 'genre' => 'drama', 'budget' => 500})
movie1.save
movie2.save
movie3.save

casting1 = Casting.new({
  'fee' => 126,
  'star_id' => star1.id,
  'movie_id' => movie1.id
  })
casting2 = Casting.new({
     'fee' => 98,
     'star_id' => star2.id,
    'movie_id' => movie1.id
    })
    casting3 = Casting.new({
      'fee' => 32,
      'star_id' => star4.id,
      'movie_id' => movie1.id
      })
      casting4 = Casting.new({
        'fee' => 156,
        'star_id' => star5.id,
        'movie_id' => movie2.id
        })
        casting5 = Casting.new({
          'fee' => 568,
          'star_id' => star3.id,
          'movie_id' => movie2.id
          })
          casting6 = Casting.new({
            'fee' => 63,
            'star_id' => star2.id,
            'movie_id' => movie3.id
            })
            casting7 = Casting.new({
              'fee' => 28,
              'star_id' => star5.id,
              'movie_id' => movie3.id
              })
casting1.save
casting2.save
casting3.save
casting4.save
casting5.save
casting6.save
casting7.save




binding.pry
nil
