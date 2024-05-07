require 'rails_helper'

RSpec.describe 'goals/index' do
  let(:goal1) { FactoryBot.create(:goal, title: 'Build a boat') }
  let(:goal2) { FactoryBot.create(:goal, title: 'Sing a song') }

  it "has a header with the name of the application" do
    assign(:goals, goal1)
    render

    expect(rendered).to match /All the goals/
  end

  it 'renders the names of goals' do
    assign(:goals, [goal1, goal2])

    render
    expect(rendered).to match(/Build a boat/)
    expect(rendered).to match(/Sing a song/)
  end

  it 'links to goal show pages' do
    assign(:goals, goal1)

    render
    expect(rendered).to have_link('Build a boat', href: goal_path(goal1))
  end
end