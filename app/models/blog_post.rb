class BlogPost < ApplicationRecord
    has_rich_text :content
    validates :title ,  presence: true
    validates :content ,  presence: true


    scope :sorted, -> { order(Arel.sql('COALESCE(published_at, updated_at) DESC')) }
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
