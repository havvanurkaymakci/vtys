using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Npgsql;
using System.Data.SqlClient;

namespace VTYS1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }


        private void Form1_Load(object sender, EventArgs e)
        {
            //ornek();
        }

        NpgsqlConnection baglanti = new NpgsqlConnection("server=localhost; port=5434; Database=Kutuphane; username=postgres; password=havva1104");
        //private string sql;
        //private NpgsqlCommand cmd;
        //private DataTable dt;
        //private void ornek()
        //{

        //    try
        //    {
        //        baglanti.Open();
        //        sql = @"select kitap_sayisi();";
        //        cmd = new NpgsqlCommand(sql, baglanti);
        //        dt = new DataTable();
        //        dt.Load(cmd.ExecuteReader());
        //        baglanti.Close();
        //        dataGridView1.DataSource = null;
        //        dataGridView1.DataSource = dt;
        //    }
        //    catch (Exception ex)
        //    {
        //        baglanti.Close();
        //        MessageBox.Show("Error:" + ex.Message);
        //    }
        //}




        private void btnListele_Click(object sender, EventArgs e)
        {
            string sorgu = " select * from \"Kitap\"";
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(sorgu, baglanti);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dataGridView1.DataSource = ds.Tables[0];
        }
        
            
        
        private void btnEkle_Click(object sender, EventArgs e)
        {
            baglanti.Open();
            NpgsqlCommand komut1 = new NpgsqlCommand("insert into \"Kitap\" ( \"kitapId\",\"kitapAdi\",\"yazarId\",\"kategoriId\",\"kutuphaneId\",\"sayfaSayisi\",\"yayineviId\",\"rafNo\") values(@p1, @p2, @p3, @p4, @p5, @p6, @p7,@p8)", baglanti);
            komut1.Parameters.AddWithValue("@p1", txtkitapId.Text);
            komut1.Parameters.AddWithValue("@p2", textKitapAdi.Text);
            komut1.Parameters.AddWithValue("@p3", int.Parse(textYazarId.Text));
            komut1.Parameters.AddWithValue("@p4", int.Parse(textKategoriId.Text));
            komut1.Parameters.AddWithValue("@p5", int.Parse(textkutuphaneId.Text));
            komut1.Parameters.AddWithValue("@p6", int.Parse(textsayfaSayisi.Text));
            komut1.Parameters.AddWithValue("@p7", textyayineviId.Text);
            komut1.Parameters.AddWithValue("@p8", textrafNo.Text);
            komut1.ExecuteNonQuery();
            baglanti.Close();
            MessageBox.Show("Kitap ekleme işlemi başarılı bir şekilde gerçekleşti.", "Bilgi", MessageBoxButtons.OK, MessageBoxIcon.Information);

        }

        private void btnSil_Click(object sender, EventArgs e)
        {
            baglanti.Open();
            NpgsqlCommand komut2 = new NpgsqlCommand("Delete From \"Kitap\" where \"kitapId\"=@p1", baglanti);
            komut2.Parameters.AddWithValue("@p1", txtkitapId.Text);
            komut2.ExecuteNonQuery();
            baglanti.Close();
            MessageBox.Show("Kitap silme işlemi başarılı bir şekilde gerçekleşti.", "Bilgi", MessageBoxButtons.OK, MessageBoxIcon.Information);

        }

        private void btnguncelle_Click(object sender, EventArgs e)
        {

            baglanti.Open();
            NpgsqlCommand komut3 = new NpgsqlCommand("update \"Kitap\" set \"kitapAdi\"=@p2, \"yazarId\"=@p3,\"kategoriId\"=@p4,\"kutuphaneId\"=@p5,\"sayfaSayisi\"=@p6,\"yayineviId\"=@p7,\"rafNo\"=@p8 where  \"kitapId\"=@p1 ", baglanti);
            komut3.Parameters.AddWithValue("@p2", textKitapAdi.Text);
            komut3.Parameters.AddWithValue("@p3", int.Parse(textYazarId.Text));
            komut3.Parameters.AddWithValue("@p4", int.Parse(textKategoriId.Text));
            komut3.Parameters.AddWithValue("@p5", int.Parse(textkutuphaneId.Text));
            komut3.Parameters.AddWithValue("@p6", int.Parse(textsayfaSayisi.Text));
            komut3.Parameters.AddWithValue("@p7", textyayineviId.Text);
            komut3.Parameters.AddWithValue("@p8", textrafNo.Text);
            komut3.Parameters.AddWithValue("@p1", txtkitapId.Text);
            komut3.ExecuteNonQuery();
            baglanti.Close();
            MessageBox.Show("Kitap güncelleme işlemi başarılı bir şekilde gerçekleşti.", "Bilgi", MessageBoxButtons.OK, MessageBoxIcon.Information);

        }

        private void btnAra_Click(object sender, EventArgs e)
        {
            //    baglanti.Open();
            //    NpgsqlCommand komut4 = new NpgsqlCommand("Select * from \"Kitap\" where \"kitapId\"::text like '% " + txtkitapId.Text + "'%", baglanti);
            //    NpgsqlDataAdapter da = new NpgsqlDataAdapter(komut4);
            //    DataSet ds = new DataSet();
            //    da.Fill(ds);
            //    dataGridView1.DataSource = ds.Tables[0];
            //    baglanti.Close();


        }

        private void textsayfaSayisi_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
