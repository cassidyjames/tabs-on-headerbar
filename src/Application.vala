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
                padding-bottom: 0;
                padding-top: 0;
            }

            .stack-switcher button {
                background-image: none;
                border: none;
                box-shadow: none;
                padding:  1em;
            }

            .stack-switcher button:checked {
                background-color: rgba(255, 255, 255, 0.5);
            }
        """;

        var main_window = new Gtk.ApplicationWindow (this);
        main_window.default_height = 400;
        main_window.default_width = 800;

        var stack = new Gtk.Stack ();

        var switcher = new Gtk.StackSwitcher ();
        switcher.halign = Gtk.Align.START;
        switcher.hexpand = true;
        switcher.stack = stack;

        int i;
        for (i = 0; i <= 3; i++) {
            string title = "Page %i".printf (i + 1);
            var page = new Gtk.Label (title);
            stack.add_titled (page, title, title);
        }

        var header = new Gtk.HeaderBar ();
        header.show_close_button = true;
        header.has_subtitle = false;
        header.set_custom_title (switcher);

        var provider = new Gtk.CssProvider ();
        try {
            provider.load_from_data (CSS, CSS.length);
            Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
        } catch (GLib.Error e) {
            return;
        }

        main_window.set_titlebar (header);
        main_window.add (stack);
        main_window.show_all ();
    }

    public static int main (string[] args) {
        var app = new TabsOnHeaderBar ();
        return app.run (args);
    }
}

