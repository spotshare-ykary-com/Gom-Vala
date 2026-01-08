using GLib;
using Gom;
using Json;

namespace Yk {
	public Gom.Repository? easy_open_sync (string db_uri, out Gom.Adapter adapter) throws GLib.Error {
		adapter = new Gom.Adapter ();
		try {
		  adapter.open_sync (db_uri);
	    }catch (Gom.Error e)
	    {
			if (e is Gom.Error.ADAPTER_OPEN) {
			    stdout.printf ("Error: %s\n", e.message);
			    adapter.close_sync ();
		        throw e;
		    }
		}
		return new Gom.Repository (adapter);
	}
	public class Monitor: Gom.Resource {
		private class bool _init = false;
		public Monitor () {
		}
	    public int64 id {get;set;default = 0;}
	    public string name {get;set;default = null;}
	    public string username {get;set;default = "admin";}
	    public string password {get;set;default = "admin";}
	    public string mid {get;set;default = null;}
	    public string connectic {get;set;default = null;}
	    public string description {get;set;default = null;}
	    [SimpleType (min = 0, max = 100)]
	    public int volume {get;set;default = 0;}
        construct {
			if (_init) return; 
			set_table ("monitor");
			set_primary_key ("id");
			set_unique ("name");
			set_unique ("mid");
			set_notnull ("name");
			set_notnull ("mid");
			set_notnull ("password");
			set_notnull ("username");
			_init = true;
        }
	}
	public class Tesla: Monitor {
		private class bool _init = false;
		[SimpleType (min = 0, max = 1000)]
	    public int64 koko {get;set;default = 0;}
	    public string surname {get;set;default = null;}		
        construct {
			if (_init) return; 
			set_table ("tesla");
			set_notnull ("koko");
			set_notnull ("surname");
			_init = true;
        }
	}
	public void main () {
		Monitor monitor = new Monitor ();
		Tesla tesla = new Tesla ();
		var ltypes = new GLib.List<GLib.Type> ();
		ltypes.append (monitor.get_type ());
		ltypes.append (tesla.get_type ());
        Gom.Adapter adapter;
        Gom.Repository repo;
		try {
		    repo = easy_open_sync ("/home/nar6du14/Projects/vala/gom/test0/test.db", out adapter);
		    repo.automatic_migrate_sync (1, (owned) ltypes);
		    adapter.close_sync ();
		} catch (Gom.Error e) {
			stdout.printf ("Error: %s\n", e.message);
		    repo = easy_open_sync ("/home/nar6du14/Projects/vala/gom/test/test.db", out adapter);
		    repo.automatic_migrate_sync (1, (owned) ltypes);
		    adapter.close_sync ();
			return;
		}
	}
}

/*
 * to compile:
 * valac --vapidir . -X -I/home/nar6du14/Projects/vala/gom -X -L/home/nar6du14/Projects/vala/gom -X -lgom --pkg glib-2.0 --pkg gio-2.0 --pkg json-glib-1.0 --pkg sqlite3 main.vala gom.vapi
 * 
 * to generate the "c" code:
 * valac --ccode --vapidir . -X -I/home/nar6du14/Projects/vala/gom -X -L/home/nar6du14/Projects/vala/gom -X -lgom --pkg glib-2.0 --pkg gio-2.0 --pkg json-glib-1.0 --pkg sqlite3 main.vala gom.vapi
 */
