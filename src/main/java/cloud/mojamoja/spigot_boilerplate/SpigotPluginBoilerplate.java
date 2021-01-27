package cloud.mojamoja.spigot_plugin_boilerplate;

import org.bukkit.plugin.java.JavaPlugin;

public class SpigotPluginBoilerplate extends JavaPlugin {
    @Override
    public void onEnable() {
        getLogger().info("Activate.");
    }

    @Override
    public void onDisable() {
        getLogger().info("Deactivate.");
    }
}