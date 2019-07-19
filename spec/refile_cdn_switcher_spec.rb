require 'spec_helper'

RSpec.describe RefileCdnSwitcher do
  include Rails.application.routes.url_helpers

  describe 'Refile.attachment_url' do
    context 'When Refile.cdn_host is set' do
      before(:context) { Refile.cdn_host = CDN_HOST }

      context 'User model says use cdn' do
        it 'return url includes cdn host' do
          user = User.create!(file: File.open(File.join('spec', 'tmp', 'file.txt')))
          expect(Refile.attachment_url(user, :file)).to include CDN_HOST
        end
      end

      context "Post model doesn't say use cdn" do
        it "return url doesn't includes cdn host" do
          post = Post.create!(file: File.open(File.join('spec', 'tmp', 'file.txt')))
          expect(Refile.attachment_url(post, :file)).not_to include CDN_HOST
        end
      end
    end

    context 'When Refile.cdn_host is not set' do
      before(:context) { Refile.cdn_host = nil }

      context 'User model says use cdn' do
        it 'return url includes root_url(localhost)' do
          user = User.create!(file: File.open(File.join('spec', 'tmp', 'file.txt')))
          expect(Refile.attachment_url(user, :file)).to include root_url
        end
      end

      context "Post model doesn't say use cdn" do
        it "return url includes root_url(localhost)" do
          post = Post.create!(file: File.open(File.join('spec', 'tmp', 'file.txt')))
          expect(Refile.attachment_url(post, :file)).to include root_url
        end
      end
    end
  end
end
