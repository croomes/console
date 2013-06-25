class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :icons, :extra_button_styles, :button_styles, :button_colors,
                :random_numbers, :random_string, :current_link, :link_level,
                :nav_collapse, :nav_active, :menu, :crumbs
  
  private
  
  def icons
    File.readlines('icons.txt')
  end

  def extra_button_styles(with = nil)
    %w(large small mini)
  end

  def button_styles
    %w(normal large small mini)
  end

  def button_colors
    %w(default red blue green gray black lightblue gold sea brown)
  end

  def random_numbers(count, from=3, to=30)
    count.times.map{ from + Random.rand(to-from) }
  end

  def random_string(length=10)
    chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789'
    password = ''
    length.times { password << chars[rand(chars.size)] }
    password
  end

  def current_link
    root_path = "/"
    current_route = request.path.sub(root_path, "").split("/") # pages/dashboard/stats.html -> ['dashboard', 'stats.html']
    return current_route.first, current_route.last.split(".").first
  end

  def link_level
    primary, secondary = current_link
    if menu[primary.to_sym][:items].keys.count > 1
      return 2
    else
      return 1
    end
  end

  def nav_collapse(options = {})
    @primary, @secondary = current_link    
    return "collapsed" unless options[:primary] == @primary
  end

  def nav_active(options = {})
    @primary, @secondary = current_link

    if options[:primary]
      return "active" if options[:primary] == @primary
    end

    if options[:secondary]
      return "active" if options[:secondary] == @secondary
    end
  end
  
  def menu
    return {
        dashboard: {
            primary: { link: "dashboard", icon: "icon-dashboard", label: "Dashboard" },
            items: {
                dashboard:    { icon: "icon-dashboard", label: "General" },
                provisioning: { icon: "icon-hand-up",   label: "Provisioning" },
                patching:     { icon: "icon-beaker",    label: "Patching" },                                                
                decoms:       { icon: "icon-beaker",    label: "Decommissions" },                

            }
        },
        hosts: {
            primary: { link: "hosts", icon: "icon-laptop", label: "Servers" },
            items: {
                hosts: { icon: "icon-laptop", label: "Servers" }
            }
        },
        automation: {
            primary: { link: "automation", icon: "icon-rocket", label: "Automation" },
            items: {
                automation: { icon: "icon-rocket", label: "Dashboard" }
            }
        },
    }
  end  

  def crumbs
    primary, secondary = current_link
    # primary = "dashboard"
    # secondary = "dashboard"
    return {
        primary:   { icon: menu[primary.to_sym][:primary][:icon], label: menu[primary.to_sym][:primary][:label]},
        secondary: {
            icon:  menu[primary.to_sym][:items][secondary.to_sym][:icon],
            label: menu[primary.to_sym][:items][secondary.to_sym][:label]
        }
    }
  end

end
