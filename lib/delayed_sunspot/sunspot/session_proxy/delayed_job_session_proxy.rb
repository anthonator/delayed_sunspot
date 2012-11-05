module Sunspot
  module SessionProxy
    class DelayedJobSessionProxy < ::Sunspot::SessionProxy::AbstractSessionProxy
      attr_reader :session

      delegate :config, :delete_dirty?, :dirty?, :more_like_this, :new_more_like_this, :new_search,
               :optimize, :reset!, :search, :setup,
               :to => :session

      def initialize(session)
        @session = session
      end

      def batch(&block)
        Delayed::Job.enqueue(DelayedSunspot::DelayedJob::SunspotJob.new(self, :batch, &block))
      end

      def commit
        Delayed::Job.enqueue(DelayedSunspot::DelayedJob::SunspotJob.new(self, :commit))
      end

      def commit_if_delete_dirty
        commit if @session.delete_dirty?
      end

      def commit_if_dirty
        commit if @session.dirty?
      end

      def index(*objects)
        Delayed::Job.enqueue(DelayedSunspot::DelayedJob::SunspotJob.new(self, :index, *objects))
      end

      def index!(*objects)
        index(*objects)
        commit
      end

      def remove(*objects, &block)
        Delayed::Job.enqueue(DelayedSunspot::DelayedJob::SunspotJob.new(self, :remove, *objects, &block))
      end

      def remove!(*objects)
        remove(*objects)
        commit
      end

      def remove_all(*classes)
        Delayed::Job.enqueue(DelayedSunspot::DelayedJob::SunspotJob.new(self, :remove_all, *classes))
      end

      def remove_all!(*classes)
        remove_all(*classes)
        commit
      end

      def remove_by_id(clazz, id)
        Delayed::Job.enqueue(DelayedSunspot::DelayedJob::SunspotJob.new(self, :remove_by_id, clazz, id))
      end

      def remove_by_id!(clazz, id)
        remove_by_id(clazz, id)
        commit
      end
    end
  end
end
