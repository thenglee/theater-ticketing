require 'rails_helper'

describe 'adding to cart' do
  fixtures :all

  it 'can add a performance to a cart' do
    login_as(users(:buyer), scope: :user)
    visit event_path(events(:bums))
    performance = events(:bum).performances.first
    within("#performance_#{performance.id}") do
      select("2", from: "ticket_count")
      click_on("add-to-cart")
    end

    expect(current_url).to match('cart')
    within("#event_#{events(:bums).id}") do
      within("#performance_#{performance.id}") do
        expect(page).to have_selector(".ticket_count", text: "2")
        expect(page).to have_selector(".subtotal", text: "$30")
      end
      expect(page).not_to have_selector("#22-06-1600")
      expect(page).not_to have_selector("#event_#{events(:romeo).id}")
    end
  end
end
