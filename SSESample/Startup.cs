using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(SSESample.Startup))]
namespace SSESample
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
