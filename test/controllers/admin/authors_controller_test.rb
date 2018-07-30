require 'test_helper'

class Admin::AuthorsControllerTest < ActionDispatch::IntegrationTest

  test 'get new author page should success' do
    get new_admin_author_path
    assert_template 'admin/authors/new'
    assert_select 'h1', 'Create new author'
    assert_select 'form', attributes: {action: '/admin/authors/create'}
    assert_response :success
  end

  test 'create author should success' do
    assert_difference 'Author.count' do
      post admin_authors_path, params: {
        author: {
          first_name: 'Joel', last_name: 'Spolsky'
        }
      }
      follow_redirect!
    end

    assert_template 'admin/authors/index'
    assert_equal 'Author Joel Spolsky was successfully created.', flash[:success]
  end

  test 'create author without last name should fail' do
    assert_no_difference 'Author.count' do
      post admin_authors_path, params: {
        author: {
          first_name: 'Joel'
        }
      }
      assert_response :success
      assert_template 'admin/authors/new'
      assert_select 'div', attributes: { class: 'field_with_errors' }
    end
  end

  test 'show author index should success' do
    get admin_authors_path
    assert_response :success
    assert_select 'table tbody tr', Author.count
    Author.all.each do |author|
      assert_select 'td', author.name
    end
  end

  test 'show author page should success' do
    get admin_author_path(id: 1)
    assert_template 'admin/authors/show'
    assert_equal 'Joel', assigns(:author).first_name
    assert_equal 'Spolsky', assigns(:author).last_name
  end

  test 'show edit page should success' do
    get edit_admin_author_path(id: 1)
    assert_select 'input',
                  attributes: { name: 'author[first_name]',
                                value: 'Joel' }
    assert_select 'input',
                  attributes: { name: 'author[last_name]',
                                value: 'Spolsky' }
  end

  test 'update author should success' do
    put admin_author_path(id: 1), params: {
      author: {
        first_name: 'Joseph',
        last_name: 'Spolsky'
      }
    }

    assert_response :redirect
    assert_redirected_to admin_author_path(id: 1)
    assert_equal 'Joseph', Author.find(1).first_name
  end

  test 'delete author' do
    assert_difference 'Author.count', -1 do
      delete admin_author_path(id: 1)
      assert_response :redirect
      assert_redirected_to admin_authors_path
      follow_redirect!
      assert_select 'div.alert-success', '×Successfully deleted author Joel Spolsky'
    end
  end

end
