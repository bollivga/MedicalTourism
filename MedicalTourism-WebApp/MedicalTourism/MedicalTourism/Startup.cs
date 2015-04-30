using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(MedicalTourism.Startup))]
namespace MedicalTourism
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
