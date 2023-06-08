using System.Security.Authentication;
using System.Security.Cryptography.X509Certificates;

var builder = WebApplication.CreateBuilder(args);

var cert = Environment.GetEnvironmentVariable("FULLCHAIN_PATH");
var privKey = Environment.GetEnvironmentVariable("PRIVKEY_PATH");

Console.WriteLine("cert: "+cert);
Console.WriteLine("privKey: "+privKey);

if (cert != null && privKey != null) {
    builder.WebHost.ConfigureKestrel(kes => {
        kes.ConfigureHttpsDefaults(https => {
            https.SslProtocols = SslProtocols.Tls12;
            https.ServerCertificate = X509Certificate2.CreateFromPemFile(cert, privKey);
            Console.WriteLine("https.ServerCertificate: "+https.ServerCertificate);
        });
    });
}


// Add services to the container.

builder.Services.AddControllers().AddJsonOptions(options => {
    options.JsonSerializerOptions.Converters.Add(new DateOnlyJsonConverter());
});
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
// builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

//app.UseHttpsRedirection();


app.UseAuthorization();

app.MapControllers();

app.Run();
