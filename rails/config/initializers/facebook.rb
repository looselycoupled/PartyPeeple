begin
  # load by environment
  tmp_fb_config = YAML.load_file("#{Rails.root.to_s}/config/facebook.yml")[Rails.env]
  
  # convert keys to symbols
  FB_CONFIG = tmp_fb_config.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
  
  # provide success message
  msg = "INFO: Loaded config/facebook.yml using #{Rails.env}"
  puts msg
  Rails.logger.info msg
rescue
  # provide failure message
  msg = "ERROR: Could not read config/facebook.yml" 
  puts msg
  Rails.logger.fatal msg
  exit(1)
end

