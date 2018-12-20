public class TabsOnHeaderBar : Gtk.Application {

    public TabsOnHeaderBar () {
        Object (
            application_id: "com.github.cassidyjames.tabs-on-headerbar",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        const string CSS = """
            .titlebar {
                padding-top: 0;
                padding-bottom: 0;
            }

            .titlebar notebook header {
                border: none;
                box-shadow: none;
                background: transparent;
                margin: 0;
            }

            /* Copy most of the .titlebar styling to get it to look right */

            .titlebar notebook {
                -gtk-icon-source: none;
                background-image:
                linear-gradient(
                    to bottom,
                    shade (
                        @colorPrimary,
                        1.04
                    ),
                    shade (
                        @colorPrimary,
                        0.94
                    )
                );
                box-shadow: inset 0 1px 0 0 alpha (shade (@colorPrimary, 1.4), 0.6);
            }

            .titlebar notebook:backdrop {
                background-image:
                linear-gradient(
                    to bottom,
                    shade (
                        @colorPrimary,
                        1.08
                    ),
                    shade (
                        @colorPrimary,
                        1.04
                    )
                );
                background-color: shade (@colorPrimary, 1.1);
            }
        """;

        var main_window = new Gtk.ApplicationWindow (this);
        main_window.default_height = 400;
        main_window.default_width = 800;

        var notebook = new Granite.Widgets.DynamicNotebook ();
        notebook.allow_restoring = true;
        notebook.allow_drag = false;
        notebook.expand = true;

        int i;
        for (i = 1; i <= 2; i++) {
            var tab = new Granite.Widgets.Tab ("Tab %d".printf (i), new ThemedIcon ("mail-mark-important-symbolic"));
            notebook.insert_tab (tab, i-1);
        }

        var header = new Gtk.HeaderBar ();
        header.show_close_button = true;
        header.has_subtitle = false;
        header.set_custom_title (notebook);

        var provider = new Gtk.CssProvider ();
        try {
            provider.load_from_data (CSS, CSS.length);
            Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
        } catch (GLib.Error e) {
            return;
        }

        main_window.set_titlebar (header);
        main_window.show_all ();
    }

    public static int main (string[] args) {
        var app = new TabsOnHeaderBar ();
        return app.run (args);
    }
}

