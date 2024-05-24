import { Routes, Route } from 'react-router-dom';

import './App.css';
import HomePage from './component/pages/HomePage';
import Users from './component/pages/users/Users';
import Stays from './component/pages/stays/Stays';
import Attractions from './component/pages/attractions/Attractions';
import Orders from './component/pages/orders/Orders';

function App() {
  return (
    <Routes>
      <Route path="/" element={<HomePage />} />
      <Route path="/users" element={<Users />} />
      <Route path="/stays" element={<Stays />} />
      <Route path="/attractions" element={<Attractions />} />
      <Route path="/orders" element={<Orders />} />
    </Routes>
  );
}

export default App;
