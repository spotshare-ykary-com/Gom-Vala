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
		public class void ma_methode (int a) {
			stdout.printf ("ax2: %d\n", a*2);
		}
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
	public void insert (string uri) {
		Monitor monitor = new Monitor ();
		Tesla tesla = new Tesla ();
		var ltypes = new GLib.List<GLib.Type> ();
		ltypes.append (monitor.get_type ());
		ltypes.append (tesla.get_type ());
        Gom.Adapter adapter;
        Gom.Repository repo;
		try {
		    repo = easy_open_sync (uri, out adapter);
		    repo.automatic_migrate_sync (1, (owned) ltypes);
		    monitor.repository = repo;
		    monitor.name = "arcgus";
		    monitor.username = "root";
		    monitor.password = "1235789";
		    monitor.mid = "752156987poioi";
		    monitor.save_sync ();
		    adapter.close_sync ();
		} catch (Gom.Error e) {
		}
	}
	public void delete (string uri) {
        Gom.Adapter adapter;
        Gom.Repository repo;
		try {
			var dummy = new Monitor ();
			var t = dummy.get_type ();
			var v = Value (typeof(string));
			v.set_string ("root");
			var f = new Gom.Filter.eq (t, "username", v);
			v.set_string ("boumzong");
			var f1 = new Gom.Filter.eq (t, "name", v);
			var f2 = new Gom.Filter.and (f, f1);
		    repo = easy_open_sync (uri, out adapter);
		    Monitor monitor = repo.find_one_sync (t, f2) as Monitor;
		    stdout.printf ("name: %s\n username: %s\n, password: %s\n", monitor.name, monitor.username, monitor.password);
		    monitor.delete_sync ();
		    adapter.close_sync ();
		} catch (Gom.Error e) {
		}
	}
	public void main () {
        Gom.Adapter adapter;
        Gom.Repository repo;
		try {
			string uri; //dir_path_to_db
			insert ();
			stdout.printf ("hercule\n");
			var dummy = new Monitor ();
			var t = dummy.get_type ();
			var v = Value (typeof(string));
			var v1 = Value (typeof(string));
			v.set_string ("root");
			var f = new Gom.Filter.eq (t, "username", v);
			v1.set_string ("arcgus");
			var f1 = new Gom.Filter.eq (t, "name", v1);
			var f2 = new Gom.Filter.and (f, f1);
		    repo = easy_open_sync (uri, out adapter);
		    ResourceGroup r_grp = repo.find_sync (t, f2) as ResourceGroup;
		    stdout.printf ("%u\n", r_grp.count);
		    if (r_grp.fetch_sync (0, r_grp.count)) {
		        foreach (Gom.Resource r in r_grp) {
				    stdout.printf ("username: %s\nname: %s\npassword: %s\n", 
				                   (r as Monitor).username,
				                   (r as Monitor).name,
				                   (r as Monitor).password);
		        }
		    }
		    adapter.close_sync ();
		} catch (Gom.Error e) {
		}
	}
}
