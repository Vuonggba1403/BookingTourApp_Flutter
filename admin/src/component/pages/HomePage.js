import Card from '../card/Card';
import Header from '../Header';
import Sidebar from '../sidebar/Sidebar';

function HomePage() {
  return (
    <div className="HomePage">
      <Sidebar />

      <Header />

      <main>
        <div className="row">
          <Card name={'Users'} icon={'person'} link={'/users'}/>

          <Card name={'Stays'} icon={'house'} link={'/stays'}/>
        </div>

        <div className="row">
          <Card name={'Attractions'} icon={'attractions'} link={'/attractions'}/>

          <Card name={'Orders'} icon={'assignment'} link={'/orders'}/>
        </div>
      </main>
    </div>
  );
}

export default HomePage;
