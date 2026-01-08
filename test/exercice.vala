using GLib;

namespace Gom {
	public async bool test () throws GLib.Error {
		stdout.printf ("hello world\n");
		return true;
    }
	public class Totem: GLib.Object {
		public class unowned char m2g[64];
		public static void calcul () {
			int a = 0;
		}
		public class int get_toto () {
			m2g[0] = '7';
			return 4;
		}
		public class string set_toto (string m3g) {
			return m3g;
		}
		private string _tr;
		public Totem (string tr) {
			Object (tr: tr);
		}
		public string tr {
			get {return _tr;}
			construct {_tr = @" copy-call $value";}
		}
		public async bool delete_async () throws GLib.Error {return true;}
		public bool save_sync () throws GLib.Error {return true;}
		/*
		private class uint8 table[64];
		public class uint8 primary_key[64];
		public class bool toto () {
			stdout.printf ("tot\n");
			return true;
		}
		*/
	}
	public delegate bool RepositoryMigrator (uint version) throws GLib.Error;
	public void main() {
		Totem t = new Totem("banana");
		stdout.printf ("%d\n", t.get_toto());
		stdout.printf ("tr: %s\n", t.tr);
		//t.tr = "pourtra";
		t.m2g = (char[]) t.set_toto ("789+fgh").data;
		//for (int i = 0; i < s.length; i++)
		//	t.m2g[i] = (char)s.data[i];
		stdout.printf ("tr: %s\n", t.tr);
		stdout.printf ("tr: %s\n", (string) t.m2g);
		string s;
		s = "bonjour";
		stdout.printf ("%s\n", s);
		s = "coco";
		stdout.printf ("%s\n", s);
	}
}
