require File.expand_path '../db', __FILE__
require File.expand_path '../domain', __FILE__

class Pods
  
  def initialize
    reset
  end
  
  def reset
    @cache = {}
  end
  
  def self.instance
    @instance ||= new
  end
  
  # Pods are ordered by name.
  #
  def each &block
    pods = Pod.all { |pods| pods.order_by(:name.asc) }
    if block_given?
      pods.each &block
    else
      pods.each
    end
  end
  
  def cache_all
    each { |pod| self[pod.id] = pod }
  end
  
  def [] id
    @cache[id]
  end
  def []= id, pod
    @cache[id] = pod
  end
  
  # Load the ids, also uses a cache.
  #
  def for all_ids
    cached_ids = all_ids.map { |id| pod = @cache[id]; pod && pod.id }.reject(&:nil?)
    loaded_pods = Pod.all { |pods| pods.where(Domain.pods[:id].in => (all_ids - cached_ids)) }
    loaded_pods.each { |pod| @cache[pod.id] = pod }
    all_ids.map { |id| @cache[id] }
  end
  
end