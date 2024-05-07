require 'rails_helper'

RSpec.describe 'goals/show' do
  it 'renders the goal' do
    assign(:goal, FactoryBot.create(:goal, title: 'Believe'))
    render
    expect(rendered).to match(/Believe/)
    expect(rendered).not_to match(/&#10003;/)
  end

  it 'shows a checkmark if completed' do
    assign(:goal, FactoryBot.create(:goal, completed: true))
    render
    expect(rendered).to match(/&#10003;/)
  end
end