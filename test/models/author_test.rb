require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  fixtures :authors

  test 'full name' do
    author = Author.create first_name: 'Joel', last_name: 'Spolsky'
    assert_equal 'Joel Spolsky', author.name
  end
end
