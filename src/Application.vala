public class TabsOnHeaderBar : Gtk.Application {

    public TabsOnHeaderBar () {
        Object (
            application_id: "com.github.cassidyjames.tabs-on-headerbar",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var main_window = new Gtk.ApplicationWindow (this);
        main_window.default_height = 300;
        main_window.default_width = 300;
        main_window.title = "Hello World";
        main_window.show_all ();
    }

    public static int main (string[] args) {
        var app = new TabsOnHeaderBar ();
        return app.run (args);
    }
}

