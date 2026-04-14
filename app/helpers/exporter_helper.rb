module ExporterHelper
  def self.is_date(d)
    d.instance_of?(Date)
  end
end
