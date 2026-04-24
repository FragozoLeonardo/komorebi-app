# frozen_string_literal: true

RSpec.shared_examples 'reviewable' do
  it 'has many review cards' do
    user = create(:user)
    subject_entity = create(described_class.to_s.underscore.to_sym)
    create(:review_card, user: user, reviewable: subject_entity)

    expect(subject_entity.review_cards.first).to be_a(ReviewCard)
  end

  it 'destroys associated review cards when destroyed' do
    user = create(:user)
    subject_entity = create(described_class.to_s.underscore.to_sym)
    create(:review_card, user: user, reviewable: subject_entity)

    expect { subject_entity.destroy }.to change(ReviewCard, :count).by(-1)
  end
end
