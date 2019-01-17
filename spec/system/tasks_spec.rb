require 'rails_helper'

describe 'タスク管理機能', type: :system do
    describe '一覧表示機能' do    
        before do
            admin = FactoryBot.create(:user, admin: true)
            user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
            FactoryBot.create(:task, name: "最初のタスク", user: user_a)
        end
    
        context 'ユーザAがログインしているとき' do
            before do
                visit login_path
                fill_in 'メールアドレス',  with: 'a@example.com'
                    fill_in 'パスワード', with: 'password'
                click_button 'ログインする'
            end
        
            it 'ユーザAが作成したタスクが表示される' do 
                expect(page).to have_content '最初のタスク'
            end
        end
    end

    describe '一覧表示機能' do    
        before do
            admin = FactoryBot.create(:user, admin: true)
            user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
            FactoryBot.create(:task, name: "1番目", user: user_a, created_at: Time.current + 2.days )
            FactoryBot.create(:task, name: "2番目", user: user_a, created_at: Time.current + 1.days )
            FactoryBot.create(:task, name: "3番目", user: user_a, created_at: Time.current)
        end
    
        context 'ユーザAがログインしているとき' do
            before do
                visit login_path
                fill_in 'メールアドレス',  with: 'a@example.com'
                    fill_in 'パスワード', with: 'password'
                click_button 'ログインする'
            end
        
            it 'ユーザAが作成したタスクが作成日時の降順に表示される' do 
                within '.table' do
                    task_names = all('.name').map(&:text)
                    expect(task_names).to eq %w(1番目 2番目 3番目) 
                end
            end
        end
    end
end
