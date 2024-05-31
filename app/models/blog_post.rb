class BlogPost < ApplicationRecord
    validates :title ,  presence: true
    validates :body ,  presence: true


    scope :sorted , -> { order(published_at: :desc , updated_at: :desc) }
    scope :draft , -> { where(published: nil) }
    scope :published , -> { where("published_at <= ?", Time.now) }
    scope :scheduled , -> { where("published_at > ?", Time.now) }
    def draft?
        published_at.nil?
    end

    def published?
       published_at && published_at <= Time.now
    end
    def scheduled?
        published_at && published_at > Time.now
    end
end
