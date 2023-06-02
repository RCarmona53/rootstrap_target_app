describe TargetPolicy do
  subject { described_class }

  permissions :index? do
    let(:user) { create(:user) }

    it 'allows access to the index action' do
      expect(subject).to permit(user)
    end
  end

  permissions :create? do
    let(:user) { create(:user) }

    it 'allows access to the create action' do
      expect(subject).to permit(user)
    end
  end

  permissions :destroy? do
    let(:user) { create(:user) }

    it 'denies access if target does not belong to the user' do
      target = create(:target)
      expect(subject).not_to permit(user, target)
    end

    it 'allows access if target belongs to the user' do
      target = create(:target, user:)
      expect(subject).to permit(user, target)
    end
  end
end
