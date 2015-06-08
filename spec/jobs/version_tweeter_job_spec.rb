require "rails_helper"

describe VersionTweeterJob do

  describe '.enqueue' do
    it "enqueues a job" do
      package = FactoryGirl.create(:package)
      version = FactoryGirl.create(:version, package_id: package.id)
      allow(Delayed::Job).to receive(:enqueue)

      VersionTweeterJob.enqueue(version.id)

      expect(Delayed::Job).to have_received(:enqueue).with(
        kind_of(VersionTweeterJob)
      )
    end
  end

  describe '#perform' do
    it 'sends a tweet' do
      package = FactoryGirl.create(:package)
      version = FactoryGirl.create(:version, package_id: package.id)
      VersionTweeterJob.new(version.id).perform
    end
  end
end
